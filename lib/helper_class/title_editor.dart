class TitleEditior {
  static String title_editor(String mytitle) {
    String my_title = mytitle.substring(14);
    String new_title;
    if (my_title.length > 72) {
      new_title =
          "${my_title.substring(0, 25)}...${my_title.substring(my_title.length - 10)}";
    } else {
      new_title = my_title;
    }

    return new_title;
  }
}
