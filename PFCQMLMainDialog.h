#pragma once

#include <QDialog>
#include <QTimer>
#include <QPointF>

class PFCQMLMainDialog : public QDialog
{
    Q_OBJECT

    Q_PROPERTY(QPointF lineSeriesOneValue READ GetLineSeriesOneValue NOTIFY lineSeriesOneValueChanged)
    Q_PROPERTY(QPointF lineSeriesTwoValue READ GetLineSeriesTwoValue NOTIFY lineSeriesTwoValueChanged)
    Q_PROPERTY(double areaSeriesOneMaxValue READ GetAreaSeriesOneMaxValue CONSTANT)
    Q_PROPERTY(QPointF areaSeriesOneUpperValue READ GetAreaSeriesOneUpperValue NOTIFY areaSeriesOneUpperValueChanged)
    Q_PROPERTY(QPointF areaSeriesOneLowerValue READ GetAreaSeriesOneLowerValue NOTIFY areaSeriesOneLowerValueChanged)
    Q_PROPERTY(double lineSeriesOneMax READ GetLineSeriesOneMax CONSTANT)
    Q_PROPERTY(QPointF areaSeriesTwoUpperValue READ GetAreaSeriesTwoUpperValue NOTIFY areaSeriesTwoUpperValueChanged)
    Q_PROPERTY(QPointF areaSeriesTwoLowerValue READ GetAreaSeriesTwoLowerValue NOTIFY areaSeriesTwoLowerValueChanged)
    Q_PROPERTY(double areaSeriesTwoMaxValue READ GetAreaSeriesTwoMaxValue CONSTANT)

public:
    PFCQMLMainDialog(QWidget *parent = nullptr);
    ~PFCQMLMainDialog() = default;

    QPointF GetLineSeriesOneValue() const { return LineSeriesDataPoint;}
    QPointF GetLineSeriesTwoValue() const { return LineSeriesTwoDataPoint;}
    double GetLineSeriesOneMax() const {return LineSeriesOneMaxValue;}

    QPointF GetAreaSeriesOneUpperValue() const {return AreaSeriesOneUpperDataValue;}
    QPointF GetAreaSeriesOneLowerValue() const {return AreaSeriesOneLowerDataValue;}
    double GetAreaSeriesOneMaxValue() const {return AreaSeriesOneMaxValue;}

    QPointF GetAreaSeriesTwoUpperValue() const {return AreaSeriesTwoUpperDataValue;}
    QPointF GetAreaSeriesTwoLowerValue() const {return AreaSeriesTwoLowerDataValue;}
    double GetAreaSeriesTwoMaxValue() const {return AreaSeriesTwoMaxValue;}

signals:
    void areaSeriesOneUpperValueChanged();
    void areaSeriesOneLowerValueChanged();
    void areaSeriesTwoUpperValueChanged();
    void areaSeriesTwoLowerValueChanged();
    void lineSeriesOneValueChanged();
    void lineSeriesTwoValueChanged();
    void lineSeriesOneMaxChanged();

private slots:
    void GraphDataTimeout();

protected:
    virtual void resizeEvent(QResizeEvent *event) override;

private:
    double RandomNumberGenerator(const double min, const double max) const;
    void CalculateLineGraphOneMaxValue();
    void CalculateAreaSeriesOneMaxValue();
    void CalculateAreaSeriesTwoMaxValue();

    QTimer* GraphDataTimer;
    QWidget* QMLContainer = nullptr;
    QPointF LineSeriesDataPoint;
    QPointF LineSeriesTwoDataPoint;
    double LineSeriesOneMaxValue=1.2;
    QPointF AreaSeriesOneUpperDataValue;
    QPointF AreaSeriesOneLowerDataValue;
    double AreaSeriesOneMaxValue=1.2;
    QPointF AreaSeriesTwoUpperDataValue;
    QPointF AreaSeriesTwoLowerDataValue;
    double AreaSeriesTwoMaxValue=1.2;
};
