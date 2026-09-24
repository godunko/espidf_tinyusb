/*
 *  Copyright (C) 2026, Vadim Godunko
 *
 *  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
 */

#include "tinyusb.h"
#include "tinyusb_default_config.h"

const int __ada_SIZEOF_tinyusb_config_t = sizeof(tinyusb_config_t);

void __ada_TINYUSB_DEFAULT_CONFIG(tinyusb_config_t *cfg)
{
    *cfg = (tinyusb_config_t)TINYUSB_DEFAULT_CONFIG();
}
