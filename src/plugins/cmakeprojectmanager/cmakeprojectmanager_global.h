// Omnia Creator Code Change //////////////////////////////////////////////////
#ifndef CMAKEPROJECTMANAGER_GLOBAL_H
#define CMAKEPROJECTMANAGER_GLOBAL_H

#include <QtGlobal>

#ifdef CMAKEPROJECTMANAGER_LIBRARY
    #define CMAKEPROJECTMANAGER_EXPORT Q_DECL_EXPORT
#else
    #define CMAKEPROJECTMANAGER_EXPORT Q_DECL_IMPORT
#endif

#endif // CMAKEPROJECTMANAGER_GLOBAL_H
///////////////////////////////////////////////////////////////////////////////
