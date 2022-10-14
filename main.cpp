#include "QMLDialog.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    QMLDialog qmlDialog;
    qmlDialog.show();
    return a.exec();
}
