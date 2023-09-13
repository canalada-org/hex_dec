with Gtkada.Intl; use Gtkada.Intl;

package body Hex_Dec_Intl is

   function "-" (Msg : String) return String is
   begin
      return Dgettext ("Hex_Dec", Msg);
   end "-";

end Hex_Dec_Intl;
