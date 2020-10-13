#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "filesystemmodel.h"

static FileSystemModel * fsm;

void init(QQmlContext *context) {
    fsm = new FileSystemModel(0,QCoreApplication::arguments().at(1));
    context->setContextProperty("fsm", fsm);
}

void fini() {
    delete fsm;
}

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);



    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);


    init(engine.rootContext());

    engine.load(url);
    int ret = app.exec();

    fini();

    return ret;
}
