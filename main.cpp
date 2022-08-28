#include "PFCQMLMainDialog.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    PFCQMLMainDialog pfcMainDialog;
    pfcMainDialog.show();
    return a.exec();
}
