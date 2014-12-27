#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QQuickItem>
#include <QScreen>


#include "smartconnect.h"

int main(int argc, char * argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName(QStringLiteral("Find Numbers Game"));
    app.setOrganizationDomain(QStringLiteral("1x.at.tut.by"));
    app.setOrganizationName(QStringLiteral("Aliaksei Verkhaturau"));
    app.setWindowIcon(QIcon("qrc:///assets/images/lenin-85x85.png"));

    QQuickView qmlView;
    qmlView.engine()->addImportPath("qml");
#if defined(Q_OS_WIN) || defined(Q_OS_MAC)
    qmlView.setResizeMode(QQuickView::SizeRootObjectToView);
    qmlView.resize(720, 480);
#endif

    QScreen * sc = app.primaryScreen();
    qreal scaleRatio = sc->logicalDotsPerInch() / 96; // sc->physicalDotsPerInch() / sc->logicalDotsPerInch();
    qmlView.engine()->rootContext()->setContextProperty("scaleRatio", scaleRatio);


#if defined(QT_NO_DEBUG) || defined(Q_OS_ANDROID) || defined(Q_OS_IOS)
    qmlView.setSource(QStringLiteral("qrc:/main.qml"));
    qmlView.engine()->rootContext()->setContextProperty("debug", QVariant(false));
#else

#if defined(Q_OS_DARWIN)
    qmlView.setSource(QStringLiteral("../../../../src/main.qml"));
#else
    qmlView.setSource(QStringLiteral("../src/main.qml"));
    //qmlView.setSource(QStringLiteral("../main.qml"));
#endif //Q_OS_DARWIN

    qmlView.engine()->rootContext()->setContextProperty("debug", QVariant(true));

    // d-tor of SmartConnect must be called after app.exec
    SmartConnect clearCacheConnection(
        static_cast<QObject *>(qmlView.rootObject()),
        SIGNAL(clearComponentCache()),
        [&qmlView]() {qmlView.engine()->clearComponentCache();});
    Q_UNUSED(clearCacheConnection);

#endif

    QObject::connect(qmlView.engine(), SIGNAL(quit()), &qmlView, SLOT(close()));
    qmlView.show();

    return app.exec();
}
