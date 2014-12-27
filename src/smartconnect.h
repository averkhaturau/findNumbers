#pragma once
#include <QtCore>
#include <functional>
#include <assert.h>

class SmartConnect : public QObject
{
    Q_OBJECT

    std::function<void()> pVoidFunc;
public:
    SmartConnect(const QObject * sender, const char * signal, std::function<void()> pFunc)
    {
        pVoidFunc = pFunc;
        QObject::connect(sender, signal, this, SLOT(voidSlot()));
    }
private slots:
    void voidSlot()
    {
        if (pVoidFunc) {
            pVoidFunc();
        }
    }
};
