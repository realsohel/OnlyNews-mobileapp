import 'package:flutter/material.dart';
import 'package:onlynewsapp/models/article_model.dart';

import '../helper/news.dart';
import 'articles.dart';

class CategoryNews extends StatefulWidget {
  // const CategoryNews({Key? key}) : super(key: key);

  final String category;
  CategoryNews({required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getCategoryNews(widget.category);
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
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),

      body:_loading
          ? const Center(
            child: CircularProgressIndicator(),)
          : Container(

               child: Column(
                children: <Widget>[
                  Text(widget.category.toUpperCase() ,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500),),
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
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ArticleView(
              blogUrl: url,
            )
        ));
      },
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
