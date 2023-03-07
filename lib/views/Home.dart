import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlynewsapp/helper/data.dart';
import 'package:onlynewsapp/models/article_model.dart';
import 'package:onlynewsapp/models/category_model.dart';
import 'package:onlynewsapp/views/articles.dart';

import '../helper/news.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    debugPrint("articles length ${articles.length}");


    // {print(articles[0].title) ;}
    // {print}

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Only",
              style: TextStyle(color: Colors.grey),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),

            )
          : Column(
              children: <Widget>[


                //Categories.
                Container(
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryName: categories[index].categoryName,
                        );
                      }),
                ),


                //NEWS
                Expanded(


                  child: ListView.builder(

                      padding: EdgeInsets.symmetric(horizontal: 16 ),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {

                        return BlogTile(
                          id: articles[index].id ?? "0",
                          imageUrl: articles[index].urlToImage ?? "",
                          title: articles[index].title ?? "",
                          description: articles[index].description ?? "The description of this article is not given.",
                          url: articles[index].url ?? "",

                          // url: articles[index].url ,
                        );
                      }),
                )
              ],
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  // const CategoryTile({Key? key}) : super(key: key);
  final imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl:imageUrl,
                  width: 120,
                  height: 60,
                  fit: BoxFit.cover,
                )),
            Container(
              width: 120,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  // const BlogTile({Key? key}) : super(key: key);

  String id, imageUrl, title, description, url ;
  BlogTile({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.url,
  });

  // required this.url

   @override
  Widget build(BuildContext context) {
    debugPrint("desc: $description");
    debugPrint("title: $title");
    return GestureDetector(
      // onTap: (){
      //   Navigator.push(context, MaterialPageRoute(
      //       builder: (context)=>ArticleView(
      //
      //   )
      //   ));
      // },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(

          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl,

                errorBuilder: (ctx,obj,_)=>SizedBox(),
          ),
            ),
            SizedBox(height: 8,),
            Text(title , style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
              fontWeight: FontWeight.w500
          ),),
            SizedBox(height: 8,),
            Text(description, style: TextStyle(
              color: Colors.black54),

            )],
        ),
      ),
    );
  }
}
