#ifndef _LIST_H
#define _LIST_H

class List
{
  private:
    String name;
    int cursor_height;
    int cursor_width;
    int row_number;
    int selection;
    int id;
    
    public:
    void intial (int row, String pname, int identity, int tf){
      name = pname;
      row_number = row;
       cursor_height = (50*row);
       cursor_width  = 50;
       selection = tf; 
       id = identity;
      }
      void display_item(){
        M5.Lcd.setCursor(cursor_width, cursor_height);
        M5.Lcd.setTextColor(BLACK);
        M5.Lcd.setTextSize(2);
        M5.Lcd.print(name);
        M5.Lcd.drawRoundRect(15, cursor_height, 10, 10, 5, BLUE);
        if(selection == 1){
          M5.Lcd.fillRoundRect(15, cursor_height, 10, 10, 5, BLUE);
        }
      }
      int is_selected(){
        return selection;
      }
      void select(){
        if(selection == 1){
          selection = 0;
        }
        else{
          selection = 1;
        }
      }
      String get_name(){
        return name;
      }
      int get_row(){
        return row_number;
      }
      int get_id(){
        return id;
      }
     
}; 
#endif
