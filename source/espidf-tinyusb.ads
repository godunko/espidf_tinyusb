--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Extensions_Allowed (On);
--  Aspect `Finalizable` is used to initialize objects automaically

package ESPIDF.TinyUSB is

   type tinyusb_config_t is limited private;

   function tinyusb_driver_install
     (config : tinyusb_config_t) return esp_err_t
       with Import, Convention => C, External_Name => "tinyusb_driver_install";

   procedure tinyusb_driver_install (config : tinyusb_config_t);

private

   sizeof_tinyusb_config_t : constant int
      with Import, Convention => C,
           Link_Name => "__ada_SIZEOF_tinyusb_config_t";

   type tinyusb_config_t_Storage is
     new C_Object_Storage (1 .. sizeof_tinyusb_config_t)
       with Convention => C;

   procedure Initialize (Self : in out tinyusb_config_t);

   type tinyusb_config_t is limited record
      Storage : tinyusb_config_t_Storage;
   end record
     with Convention  => C,
          Finalizable =>
            (Initialize           => Initialize,
             Relaxed_Finalization => True);

   pragma Assert
     (tinyusb_config_t'Size
        = sizeof_tinyusb_config_t * C_Storage_Element'Size);

end ESPIDF.TinyUSB;
