#include "fileio.h"

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <QSplashScreen>

int
main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    app.setApplicationName("demon-presentation-board");
    app.setOrganizationName("waterbear");
    QQuickStyle::setStyle("material");

    QQmlApplicationEngine engine;

    FileIO fileio;
    engine.rootContext()->setContextProperty("fileio",&fileio);
    engine.load(QUrl(QStringLiteral("qrc:/src/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
