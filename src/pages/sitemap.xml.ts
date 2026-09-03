import type { APIRoute } from 'astro';
import { getCollection } from 'astro:content';

const SITE = 'https://heymuster.com';

export const GET: APIRoute = async () => {
  const posts = await getCollection('blog');
  const urls = [
    { loc: `${SITE}/`, pri: '1.0', freq: 'weekly' },
    { loc: `${SITE}/challenge`, pri: '0.9', freq: 'daily' },
    { loc: `${SITE}/log`, pri: '0.8', freq: 'weekly' },
    ...posts.map(p => ({ loc: `${SITE}/log/${p.id}`, pri: '0.7', freq: 'monthly', lastmod: p.data.date.toISOString().slice(0, 10) })),
  ];
  const body = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map(u => `  <url><loc>${u.loc}</loc>${'lastmod' in u ? `<lastmod>${(u as any).lastmod}</lastmod>` : ''}<changefreq>${u.freq}</changefreq><priority>${u.pri}</priority></url>`).join('\n')}
</urlset>`;
  return new Response(body, { headers: { 'Content-Type': 'application/xml' } });
};
