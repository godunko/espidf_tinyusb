--
--  Copyright (C) 2026, Vadim Godunko
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

pragma Extensions_Allowed (On);
--  Aspect `Finalizable` is used to initialize objects automaically

package ESPIDF.TinyUSB is

   type tinyusb_config_t is limited private;
   --  TinyUSB driver configuration.
   --
   --  Objects of this type are automatically initialized with target
   --  defaults (as `TINYUSB_DEFAULT_CONFIG` does). The default port is
   --  `TINYUSB_PORT_HIGH_SPEED_0` on ESP32-P4 and ESP32-S31,
   --  `TINYUSB_PORT_FULL_SPEED_0` on other supported targets.

   function tinyusb_driver_install
     (config : tinyusb_config_t) return esp_err_t
       with Import, Convention => C, External_Name => "tinyusb_driver_install";
   --  Install the TinyUSB device driver and start the TinyUSB task.
   --
   --  This helper configures the USB PHY when requested, prepares
   --  descriptors, initializes the TinyUSB stack, and starts the TinyUSB
   --  task.
   --
   --  Note: When supplying a custom composite device descriptor with an
   --  Interface Association Descriptor, keep `bDeviceClass` as
   --  `TUSB_CLASS_MISC` and `bDeviceSubClass` as `MISC_SUBCLASS_COMMON`.
   --  @param config TinyUSB stack configuration.
   --  @return
   --    - `ESP_OK` if driver was installed successfully
   --    - `ESP_ERR_INVALID_ARG` if `config` contains unsupported port or
   --      task settings
   --    - `ESP_ERR_INVALID_STATE` if the TinyUSB device task is already
   --      running
   --    - `ESP_ERR_NO_MEM` if memory allocation fails during startup
   --    - other error codes from TinyUSB task startup, USB PHY setup,
   --      descriptor setup, or power management initialization

   procedure tinyusb_driver_install (config : tinyusb_config_t);
   --  Install the TinyUSB device driver and start the TinyUSB task.
   --
   --  This helper configures the USB PHY when requested, prepares
   --  descriptors, initializes the TinyUSB stack, and starts the TinyUSB
   --  task.
   --
   --  Note: When supplying a custom composite device descriptor with an
   --  Interface Association Descriptor, keep `bDeviceClass` as
   --  `TUSB_CLASS_MISC` and `bDeviceSubClass` as `MISC_SUBCLASS_COMMON`.
   --  @param config TinyUSB stack configuration.
   --  @raise ESPIDF_Error raised on error:
   --    - `ESP_ERR_INVALID_ARG` if `config` contains unsupported port or
   --      task settings
   --    - `ESP_ERR_INVALID_STATE` if the TinyUSB device task is already
   --      running
   --    - `ESP_ERR_NO_MEM` if memory allocation fails during startup
   --    - other error codes from TinyUSB task startup, USB PHY setup,
   --      descriptor setup, or power management initialization

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
