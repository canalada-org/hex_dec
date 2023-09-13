with Gtk.Window; use Gtk.Window;
with Gtk.Table; use Gtk.Table;
with Gtk.Label; use Gtk.Label;
with Gtk.GEntry; use Gtk.GEntry;
with Glib.Unicode; use Glib.Unicode;
with Gtk.Button; use Gtk.Button;

package Ventana_Conversor_Pkg is

   type Ventana_Conversor_Record is new Gtk_Window_Record with record
      Tabla_Conversor : Gtk_Table;
      Hex_Label       : Gtk_Label;
      Dec_Label       : Gtk_Label;
      Entry_Hex       : Gtk_Entry;
      Entry_Dec       : Gtk_Entry;
      Boton_Convertir : Gtk_Button;
      Boton_Imprimir  : Gtk_Button;
   end record;

   type Ventana_Conversor_Access is access Ventana_Conversor_Record'Class;

   procedure Gtk_New
     (Ventana_Conversor : out Ventana_Conversor_Access);

   procedure Initialize
     (Ventana_Conversor : access Ventana_Conversor_Record'Class);

end Ventana_Conversor_Pkg;
