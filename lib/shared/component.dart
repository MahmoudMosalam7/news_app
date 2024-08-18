import 'package:flutter/material.dart';
import 'package:news/screens/webview/web_view_screen.dart';

Widget buildArticleItem(article,context,isDark) => GestureDetector(
  onTap: (){
    print("url = ${article['url']}");
    navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: NetworkImage("${article['urlToImage'] ?? "https://thumbs.dreamstime.com/b/news-newspapers-folded-stacked-word-wooden-block-puzzle-dice-concept-newspaper-media-press-release-42301371.jpg"}")
                  ,fit: BoxFit.cover
              )
          ),
        ),
        const SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(""
                      "${article['title']}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDark == false ?Colors.black : Colors.white
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text("${article['publishedAt']}",
                  style: const TextStyle(
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);
Widget myDivider() => const Padding(
  padding: EdgeInsets.all(20.0),
  child: Divider(
    color: Colors.grey, // Set the color to gray
    thickness: 1.0, // You can adjust the thickness as needed
  ),
);
Widget articleBuilder(list,context,isDark,{isSearch = false}){
  if(list.isNotEmpty){

    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index)=>buildArticleItem(list[index],context,isDark),
        separatorBuilder: (context,index)=>myDivider(),
        itemCount: 10);
  }
  else {
    return isSearch ?Container() : const Center(child: CircularProgressIndicator(color: Colors.deepOrange,));
  }
}
Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
   void Function(String)? onChange,
  Color borderColor = Colors.deepOrange,
  Color labelColor = Colors.deepOrange,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,

    validator: validate,
    onChanged: onChange,
    decoration:  InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: labelColor),
      prefixIcon: Icon(prefix, color: labelColor),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
      ),
    ),
  );
}

void navigateTo(context,widget)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));