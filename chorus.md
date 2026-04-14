This is some brainstorming/notes/ideas for a server inspired by Federated Wiki and several FW concepts, but isn't FedWiki, will have very limited, if any compatibility.

# Guiding principles in no meaningful order

1. A farm will be the level of centralization, (in contrast to a site in FedWiki).
   - After watching several heavy users, organizing a collection of pages by site make a lot of sense, so it should be really easy to make new sites.
   - A 'farm' is an acceptable unit for system administration purposes.  That is the owner of the farm is responsible for the system administration, system maintaince, managing users, and any moderation or dispute issues that arise on the farm.  This allows some (limited) patterns that require centralization.
   - A 'farm' is a server and can have a favorable value for effort of having a "heavy" server.  For example, a farm can publish RSS feeds, search services, mirroring/caching, etc.
2. A site will be a route on the farm, e.g. my_site will be at www.example.com/my_site, (in contrast to my_site.example.com).
3. Pages will be stored at rest as HTML with content fully resolved and able to be served without computation.
   - (in contrast to FedWiki where pages are stored as JSON, with `[WikiLinks]` that need (resolution at user runtime).  Specifically, the context will be fixed by the author at edit time and not be variable based on the user's context/state.
   - Editting can be done as a mode, for example as Markdown or Markdown Wiki, in which case, the user's editing environment can provide the affordances of those simplified environments by doing an HTML -> edit formation and saving the contents will convert that format back to HTML.
   - Editting can be down as raw HTML.
4. TBD what the journaling mechanism is, but quite likely text diff of the html.
5. A central toolkit will be based around HTML rewriting (e.g. a version of xsltproc or something).  E.g. to change all the hrefs from one site to another would be a source pattern and target pattern.
6. Most likely based on an sqlite3 database.  These can be performant for the kinds of operations and scales this project is likely to encounter.
7. The tool needs to make developing collaborative content easy and allow for high quality web publishing options.  This likely implies that there are versions, need to support multiple authors, internal comments, etc.
8. "custom" plugin support will largely be provided by HTML templates.  E.g. `<img ...>` will make for an image plugin.  A very simple DSL can make for a generic interactive wizard for creating, editing, etc.
