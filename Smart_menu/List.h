#ifndef _LIST_H
#define _LIST_H

class List
{
  private:
    String name;
    int cursor_height;
    int cursor_width;
    int row_number;
    bool selection;
    
    public:
    void intial (int row, String pname){
      name = pname;
      row_number = row;
       cursor_height = (50*row);
       cursor_width  = 50;
       selection = false; 
      }
      void display_item(){
        M5.Lcd.setCursor(cursor_width, cursor_height);
        M5.Lcd.setTextColor(BLACK);
        M5.Lcd.setTextSize(2);
        M5.Lcd.print(name);
        M5.Lcd.drawRoundRect(15, cursor_height, 10, 10, 5, BLUE);
        if(selection){
          M5.Lcd.fillRoundRect(15, cursor_height, 10, 10, 5, BLUE);
        }
      }
      int get_cursorHeight(){
        return cursor_height;
      }
      bool is_selected(){
        return selection;
      }
      void select(){
        if(selection){
          selection = false;
        }
        else{
          selection = true;
        }
      }
      String get_name(){
        return name;
      }
      int get_row(){
        return row_number;
      }
     
}; 
#endif
