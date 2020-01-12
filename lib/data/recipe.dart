import 'package:choosepad/constants.dart';
import 'package:choosepad/data/tag.dart';

class Recipe {
  final String recipeId;
  final Tag tag;
  final String title;
  final String description;
  final String imageUrl;

  Recipe(this.recipeId, this.tag, this.title, this.description, this.imageUrl);

  String getLink() {
    return videoPath + recipeId;
  }
}

Recipe _getDummyRecipe1() {
  return Recipe(
    "7454",
    getDummyTag(),
    "ウチの黄金比*鶏の照り焼き～お弁当にも…",
    "【殿堂入り♡沢山のれぽ感謝いたします】 とっても簡単な『私の照り焼きの黄金比』です♪ 色々アレンジ楽しんで下さい^^",
    "https://img.cpcdn.com/videos/7454/140x90c/b2c39af83b9f45d5012e58c01c19ed91.jpg",
  );
}

Recipe _getDummyRecipe2() {
  return Recipe(
    "7453",
    getDummyTag(),
    "【基本】フライパンで簡単♪親子丼の黄金比",
    "人気のレシピ15品以上の平均的な分量を調べて黄金比を計算。美味です。卵を２回に分けて入れることでとろっとろの親子丼に！",
    "https://img.cpcdn.com/videos/7453/140x90c/35125429cdaf8388760284c11f73ae1b.jpg",
  );
}

Recipe _getDummyRecipe3() {
  return Recipe(
    "7360",
    getDummyTag(),
    "とろーり。半熟卵の肉巻きスコッチエッグ。",
    "半熟卵に豚肉をまいて揚げ焼きするだけ。 スコッチエッグより手軽です。 パン粉なしなので糖質制限さんにも◎",
    "https://img.cpcdn.com/videos/7360/140x90c/fdfe2a92b7d536bc48d6afc3abcdcf28.jpg",
  );
}

List<Recipe> getDummyRecipeList() {
  return [
    _getDummyRecipe1(),
    _getDummyRecipe2(),
    _getDummyRecipe3(),
  ];
}
