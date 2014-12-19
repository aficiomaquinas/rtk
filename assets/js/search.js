---
---
var docs =
[
{% for post in site.pages %}
{% if post.layout == 'kanji' %}
  {% include post.json %},
{% endif %}  
{% endfor %}
];

// init lunr
var idx = lunr(function () {
  this.field('keyword', 10);
  this.field('elements');
});
// add each document to be index
for(var index in docs) {
  idx.add(docs[index]);
}
