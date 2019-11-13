#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int
main(int argc, char* argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setApplicationName("demon-presentation-board-trident");
    app.setOrganizationName("waterbear");
    QQuickStyle::setStyle("material");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
