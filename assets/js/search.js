---
---
var docs =
[
{% for post in site.pages %}
{% if post.layout == 'post' %}
  {% include post.json %},
{% endif %}  
{% endfor %}
];

// init lunr
var idx = lunr(function () {
  this.field('title', 10);
  this.field('content');
});
// add each document to be index
for(var index in docs) {
  idx.add(docs[index]);
}
