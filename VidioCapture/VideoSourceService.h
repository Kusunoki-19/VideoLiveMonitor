#ifndef VIDEOSOURCESERVICE_H
#define VIDEOSOURCESERVICE_H

#include <QObject>
#include <QMediaObject>
#include <QVideoProbe>

class VideoSourceService : public QObject
{
    Q_OBJECT
public:
    explicit VideoSourceService(QObject *parent = nullptr);

    Q_INVOKABLE bool setMonitorSource (QMediaObject* newMonitorSource);
signals:

private slots:
    void _onVideoFrameProbed(const QVideoFrame &frame);

private:
    QVideoProbe * m_pVideoProbe = nullptr;


};

#endif // VIDEOSOURCESERVICE_H
