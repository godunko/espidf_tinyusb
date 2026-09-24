--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with ESPIDF.Ada_ESP_Check_Error;

package body ESPIDF.TinyUSB is

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize (Self : in out tinyusb_config_t) is

      procedure Imported (config : out tinyusb_config_t)
        with Import, Convention => C,
             External_Name => "__ada_TINYUSB_DEFAULT_CONFIG";

   begin
      Imported (Self);
   end Initialize;

   ----------------------------
   -- tinyusb_driver_install --
   ----------------------------

   procedure tinyusb_driver_install (config : tinyusb_config_t) is
   begin
      Ada_ESP_Check_Error (tinyusb_driver_install (config));
   end tinyusb_driver_install;

end ESPIDF.TinyUSB;
