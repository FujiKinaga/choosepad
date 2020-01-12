class Tag {
  final String tagId;
  final String label;

  Tag(this.tagId, this.label);
}

Tag getDummyTag() {
  return Tag("12", "晩ごはん");
}
