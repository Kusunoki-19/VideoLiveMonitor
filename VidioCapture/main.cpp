#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "VideoSourceService.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterSingletonType("VideoSourceComponents", 1, 0, "VideoSourceService",
                             [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QJSValue {
        Q_UNUSED(engine)

        static int seedValue = 5;
        QJSValue example = scriptEngine->newObject();
        example.setProperty("someProperty", seedValue++);
        return example;
    });
    qmlRegisterSingletonType<VideoSourceService>
            ("VideoSourceComponents", 1, 0, "VideoSourceService",
             [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)

        VideoSourceService *instance = new(std::nothrow) VideoSourceService();
        return instance;
    });

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
