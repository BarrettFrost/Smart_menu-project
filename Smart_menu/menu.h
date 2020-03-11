#ifndef _MENU_H
#define _MENU_H

class Menu
{
  private:
    String name;
    int cal;
    bool veg;
    bool gluten;
    bool allergy;
    int cursor_height;
    int cursor_width;
    int row_number;
    bool selection;
    bool allowed;

  public:
    void intial (int row, String pname, int calorie, bool vegan, bool glut_f, bool nut ) {
      name = pname;
      cal = calorie;
      veg = vegan;
      gluten = glut_f;
      allergy = nut;
      row_number = row;
      cursor_height = (20 * row) + 50;
      cursor_width  = 50;
      selection = false;
      allowed = true;
    }
    void display_item() {
      M5.Lcd.setCursor(cursor_width-20, cursor_height);
      M5.Lcd.setTextColor(BLACK);
      M5.Lcd.setTextSize(1);
      M5.Lcd.print(name);
      M5.Lcd.drawRoundRect(15, cursor_height, 10, 10, 5, BLUE);
      M5.Lcd.drawRoundRect(300, cursor_height, 10, 10, 5, BLUE);
      M5.Lcd.drawNumber(cal, 140, cursor_height);
      if (veg) {
        M5.Lcd.setCursor(cursor_width+ 150, cursor_height);
        M5.Lcd.print("V");
      }
      if (gluten) {
        M5.Lcd.setCursor(cursor_width + 190, cursor_height);
        M5.Lcd.print("GF");
      }
      if (allergy) {
        M5.Lcd.setCursor(cursor_width+ 230, cursor_height);
        M5.Lcd.print("N");
      }
      if (selection) {
        M5.Lcd.fillRoundRect(15, cursor_height, 10, 10, 5, BLUE);
      }
      if (!allowed) {
        M5.Lcd.fillRoundRect(300, cursor_height, 10, 10, 5, RED);
      }
    }
    bool get_veg(){
      return veg;
    }
    bool get_gluten(){
      return gluten;
    }
    bool get_allergy(){
      return allergy;
    }
    bool is_selected() {
      return selection;
    }
    void select() {
      if (selection) {
        selection = false;
      }
      else {
        selection = true;
      }
    }
    String get_name() {
      return name;
    }
    int get_cal(){
      return cal;
    }
    void is_allowed( int vegan, int glut_f, int nut  ) {
      if (!veg && vegan == 1) {
        allowed = false;
      }
      if (!gluten && glut_f == 1) {
        allowed = false;
      }
      if (allergy && nut == 1) {
        allowed = false;
      }
    }
};
#endif
