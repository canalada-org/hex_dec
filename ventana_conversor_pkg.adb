with Glib; use Glib;
with Gtk; use Gtk;
with Gdk.Types; use Gdk.Types;
with Gtk.Widget; use Gtk.Widget;
with Gtk.Enums; use Gtk.Enums;
with Gtkada.Handlers; use Gtkada.Handlers;
with Callbacks_Hex_Dec; use Callbacks_Hex_Dec;
with Hex_Dec_Intl; use Hex_Dec_Intl;
with Ventana_Conversor_Pkg.Callbacks; use Ventana_Conversor_Pkg.Callbacks;

package body Ventana_Conversor_Pkg is

   procedure Gtk_New (Ventana_Conversor : out Ventana_Conversor_Access) is
   begin
      Ventana_Conversor := new Ventana_Conversor_Record;
      Ventana_Conversor_Pkg.Initialize (Ventana_Conversor);
   end Gtk_New;

   procedure Initialize
     (Ventana_Conversor : access Ventana_Conversor_Record'Class)
   is
      pragma Suppress (All_Checks);
      Pixmaps_Dir : constant String := "pixmaps/";
      V : Integer;
   begin
      Gtk.Window.Initialize (Ventana_Conversor, Window_Toplevel);
      Set_Title (Ventana_Conversor, -"Conversor hexadecimal > decimal");
      Set_Position (Ventana_Conversor, Win_Pos_None);
      Set_Modal (Ventana_Conversor, False);

      Gtk_New (Ventana_Conversor.Tabla_Conversor, 2, 3, False);
      Set_Row_Spacings (Ventana_Conversor.Tabla_Conversor, 0);
      Set_Col_Spacings (Ventana_Conversor.Tabla_Conversor, 0);

      Gtk_New (Ventana_Conversor.Hex_Label, -("Hexadecimal"));
      Set_Alignment (Ventana_Conversor.Hex_Label, 0.0, 0.5);
      Set_Padding (Ventana_Conversor.Hex_Label, 2, 2);
      Set_Justify (Ventana_Conversor.Hex_Label, Justify_Left);
      Set_Line_Wrap (Ventana_Conversor.Hex_Label, False);
      Set_Selectable (Ventana_Conversor.Hex_Label, False);
      Set_Use_Markup (Ventana_Conversor.Hex_Label, False);
      Set_Use_Underline (Ventana_Conversor.Hex_Label, False);

      Attach
        (Ventana_Conversor.Tabla_Conversor,
         Ventana_Conversor.Hex_Label,      Left_Attach  => 0,
         Right_Attach  => 1,
         Top_Attach  => 0,
         Bottom_Attach  => 1,
         Xoptions  => Fill,
         Xpadding  => 0,
         Ypadding  => 0);
      Gtk_New (Ventana_Conversor.Dec_Label, -("Decimal"));
      Set_Alignment (Ventana_Conversor.Dec_Label, 0.0, 0.5);
      Set_Padding (Ventana_Conversor.Dec_Label, 2, 2);
      Set_Justify (Ventana_Conversor.Dec_Label, Justify_Left);
      Set_Line_Wrap (Ventana_Conversor.Dec_Label, False);
      Set_Selectable (Ventana_Conversor.Dec_Label, False);
      Set_Use_Markup (Ventana_Conversor.Dec_Label, False);
      Set_Use_Underline (Ventana_Conversor.Dec_Label, False);

      Attach
        (Ventana_Conversor.Tabla_Conversor,
         Ventana_Conversor.Dec_Label,      Left_Attach  => 0,
         Right_Attach  => 1,
         Top_Attach  => 1,
         Bottom_Attach  => 2,
         Xoptions  => Fill,
         Xpadding  => 0,
         Ypadding  => 0);
      Gtk_New (Ventana_Conversor.Entry_Hex);
      Set_Editable (Ventana_Conversor.Entry_Hex, True);
      Set_Max_Length (Ventana_Conversor.Entry_Hex, 0);
      Set_Text (Ventana_Conversor.Entry_Hex, -(""));
      Set_Visibility (Ventana_Conversor.Entry_Hex, True);
      Set_Invisible_Char (Ventana_Conversor.Entry_Hex, UTF8_Get_Char ("*"));

      Attach
        (Ventana_Conversor.Tabla_Conversor,
         Ventana_Conversor.Entry_Hex,      Left_Attach  => 1,
         Right_Attach  => 2,
         Top_Attach  => 0,
         Bottom_Attach  => 1,
         Xpadding  => 3,
         Ypadding  => 3);
      Entry_Callback.Connect
        (Ventana_Conversor.Entry_Hex, "editing_done",
         Entry_Callback.To_Marshaller (Convertir_Hex_Dec'Access), False);
      Gtk_New (Ventana_Conversor.Entry_Dec);
      Set_Editable (Ventana_Conversor.Entry_Dec, True);
      Set_Max_Length (Ventana_Conversor.Entry_Dec, 0);
      Set_Text (Ventana_Conversor.Entry_Dec, -(""));
      Set_Visibility (Ventana_Conversor.Entry_Dec, True);
      Set_Invisible_Char (Ventana_Conversor.Entry_Dec, UTF8_Get_Char ("*"));

      Attach
        (Ventana_Conversor.Tabla_Conversor,
         Ventana_Conversor.Entry_Dec,      Left_Attach  => 1,
         Right_Attach  => 2,
         Top_Attach  => 1,
         Bottom_Attach  => 2,
         Xpadding  => 3,
         Ypadding  => 3);
      Gtk_New (Ventana_Conversor.Boton_Convertir, -"Convertir");
      Set_Relief (Ventana_Conversor.Boton_Convertir, Relief_Normal);

      Attach
        (Ventana_Conversor.Tabla_Conversor,
         Ventana_Conversor.Boton_Convertir,      Left_Attach  => 2,
         Right_Attach  => 3,
         Top_Attach  => 0,
         Bottom_Attach  => 1,
         Xoptions  => Fill,
         Xpadding  => 3,
         Ypadding  => 3);
      Button_Callback.Connect
        (Ventana_Conversor.Boton_Convertir, "clicked",
         Button_Callback.To_Marshaller (Convertir_Hex_Dec'Access), False);
      Gtk_New (Ventana_Conversor.Boton_Imprimir, -"Imprimir");
      Set_Relief (Ventana_Conversor.Boton_Imprimir, Relief_Normal);

      Attach
        (Ventana_Conversor.Tabla_Conversor,
         Ventana_Conversor.Boton_Imprimir,      Left_Attach  => 2,
         Right_Attach  => 3,
         Top_Attach  => 1,
         Bottom_Attach  => 2,
         Xoptions  => Fill,
         Xpadding  => 3,
         Ypadding  => 3);
      Button_Callback.Connect
        (Ventana_Conversor.Boton_Imprimir, "clicked",
         Button_Callback.To_Marshaller (Imprimir_Hex'Access), False);
      Add (Ventana_Conversor, Ventana_Conversor.Tabla_Conversor);
      Return_Callback.Connect
        (Ventana_Conversor, "delete_event", Gtk_Main_Quit'Access, False);
   end Initialize;

end Ventana_Conversor_Pkg;
