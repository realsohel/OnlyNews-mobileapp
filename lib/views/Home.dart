import 'package:flutter/material.dart';
import 'package:onlynewsapp/helper/data.dart';
import 'package:onlynewsapp/models/article_model.dart';
import 'package:onlynewsapp/models/category_model.dart';

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

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Text("Only", style: TextStyle(
              color: Colors.grey
            ),),
            Text("News" , style: TextStyle(
              color: Colors.blue
            ),)
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),

      body:  _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),

        ),
      ):Container(
        child: Column(
          children: <Widget>[
            //Categories.
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 70,
              child: ListView.builder(
                itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index){
                  return CategoryTile(
                    imageUrl: categories[index].imageUrl,
                    categoryName: categories[index].categoryName,
                  );
                  }),
            ),

            //NEWS
            Container(
              child:ListView.builder(
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context ,index){
                  return BlogTile(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url ,
                  );
                  }) ,
            )
          ],
        ),
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
    return  GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(right: 16 ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl, width: 120, height: 60, fit: BoxFit.cover,)
            ),
             Container(
               width: 120, height: 60,
               alignment: Alignment.center,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(6),
                 color: Colors.black26,
               ),
               child: Text(categoryName, style: TextStyle(
                 color: Colors.white,
                 fontSize: 16,
                 fontWeight: FontWeight.w500
               ),),
             )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  // const BlogTile({Key? key}) : super(key: key);

   final String imageUrl, title, desc,url ;
  BlogTile({required this.imageUrl,
    required this.title,
    required this.desc ,
    required this.url});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: <Widget>[
          Image.network(imageUrl),
          Text(title),
          Text(desc)
        ],
      ),
    );
  }
}

