#include "PFCQMLMainDialog.h"
#include <QQmlContext>
#include <QQuickView>

namespace
{
   constexpr int MAIN_DIALOG_WIDTH = 780;
   constexpr int MAIN_DIALOG_HEIGHT = 480;
}

//TODO: correctly instantiate with different data // DONE!
//TODO: be able to dynamically createSeries within components, so that can reuse.
//TODO: be able to update "numbers" data from CompoundComponent. //DONE!
//TODO: be able to open overlay in QML for changing max.
//TODO: test gradients.

PFCQMLMainDialog::PFCQMLMainDialog(QWidget *parent)
    : QDialog(parent)
    , GraphDataTimer(new QTimer(this))
{
    GraphDataTimer->setSingleShot(false);
    GraphDataTimer->setInterval(1000);

    setWindowTitle("QML Basic Charts Demo");
    setMinimumSize(MAIN_DIALOG_WIDTH, MAIN_DIALOG_HEIGHT);
    QQuickView* qmlView = new QQuickView();
    qmlView->setResizeMode(QQuickView::SizeRootObjectToView);
    qmlView->setSource(QUrl("qrc:///PFCApp/Resource_Files/QML/PFCMainDialog.qml"));
    QMLContainer = QWidget::createWindowContainer(qmlView, this);
    QMLContainer->resize(size());
    qmlView->rootContext()->setContextProperty("pfcData", this);

    connect(GraphDataTimer, &QTimer::timeout, this, &PFCQMLMainDialog::GraphDataTimeout);
    GraphDataTimer->start(1000);
}

void PFCQMLMainDialog::GraphDataTimeout()
{
    //Note: Yes this is bad practice, but the point is to show how these can be separated into different slots and updated asynchronously.
    LineSeriesDataPoint.setX(LineSeriesDataPoint.x()+1);
    LineSeriesDataPoint.setY(RandomNumberGenerator(0, 3.0));
    CalculateLineGraphOneMaxValue();
    emit lineSeriesOneValueChanged();

    LineSeriesTwoDataPoint.setX(LineSeriesTwoDataPoint.x()+1);
    LineSeriesTwoDataPoint.setY(RandomNumberGenerator(0, 11.0));
    CalculateLineGraphOneMaxValue();
    emit lineSeriesTwoValueChanged();

    AreaSeriesOneUpperDataValue.setX(AreaSeriesOneUpperDataValue.x()+1);
    AreaSeriesOneUpperDataValue.setY(RandomNumberGenerator(0, 0.5));
    CalculateAreaSeriesOneMaxValue();
    emit areaSeriesOneUpperValueChanged();

    AreaSeriesOneLowerDataValue.setX(AreaSeriesOneLowerDataValue.x()+1);
    AreaSeriesOneLowerDataValue.setY(RandomNumberGenerator(0, 1.0));
    CalculateAreaSeriesOneMaxValue();
    emit areaSeriesOneLowerValueChanged();

    AreaSeriesTwoUpperDataValue.setX(AreaSeriesTwoUpperDataValue.x()+1);
    AreaSeriesTwoUpperDataValue.setY(RandomNumberGenerator(0, 0.5));
    CalculateAreaSeriesTwoMaxValue();
    emit areaSeriesTwoUpperValueChanged();

    AreaSeriesTwoLowerDataValue.setX(AreaSeriesOneLowerDataValue.x()+1);
    AreaSeriesTwoLowerDataValue.setY(RandomNumberGenerator(0, 1.0));
    CalculateAreaSeriesTwoMaxValue();
    emit areaSeriesTwoLowerValueChanged();
}

void PFCQMLMainDialog::resizeEvent(QResizeEvent *event)
{
    QMLContainer->resize(size());
    QDialog::resizeEvent(event);
}

double PFCQMLMainDialog::RandomNumberGenerator(const double min, const double max) const
{
    return min + (double)rand() / RAND_MAX * (max-min);
}

void PFCQMLMainDialog::CalculateLineGraphOneMaxValue()
{
    LineSeriesOneMaxValue = qMax(LineSeriesOneMaxValue, qMax((double)LineSeriesDataPoint.y(), (double)LineSeriesTwoDataPoint.y()));
}

void PFCQMLMainDialog::CalculateAreaSeriesOneMaxValue()
{
    AreaSeriesOneMaxValue = qMax(AreaSeriesOneMaxValue, qMax((double)AreaSeriesOneUpperDataValue.y(), (double)AreaSeriesOneLowerDataValue.y()));
}

void PFCQMLMainDialog::CalculateAreaSeriesTwoMaxValue()
{
    AreaSeriesTwoMaxValue = qMax(AreaSeriesTwoMaxValue, qMax((double)AreaSeriesTwoUpperDataValue.y(), (double)AreaSeriesTwoLowerDataValue.y()));
}

