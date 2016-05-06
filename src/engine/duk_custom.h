#include "version.h"

#define DUK_USE_FASTINT

#if defined(MINISPHERE_SPHERUN)
#undef DUK_USE_TARGET_INFO
#define DUK_USE_TARGET_INFO PRODUCT_NAME VERSION_NAME
#define DUK_USE_DEBUGGER_SUPPORT
#define DUK_USE_DEBUGGER_FWD_PRINTALERT
#define DUK_USE_DEBUGGER_PAUSE_UNCAUGHT
#define DUK_USE_DEBUGGER_INSPECT
#define DUK_USE_INTERRUPT_COUNTER
#endif
