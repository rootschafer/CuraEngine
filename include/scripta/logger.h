#ifndef SCRIPTA_LOGGER_H
#define SCRIPTA_LOGGER_H

#include <string>
#include <vector>
#include <utils/section_type.h>

namespace scripta {

    // Mock CellVDI
    struct CellVDI {
        template<typename T>
        CellVDI(const std::string& name, T value) {}
    };

    // Mock PointVDI
    struct PointVDI {
        template<typename T>
        PointVDI(const std::string& name, T value) {}
    };

    // Mock log function (variadic template to accept any arguments)
    template<typename... Args>
    void log(Args&&... args) {}

    // Mock setAll function
    template<typename... Args>
    void setAll(Args&&... args) {}

}

#endif // SCRIPTA_LOGGER_H
