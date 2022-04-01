#ifndef VIDEOSOURCESERVICE_H
#define VIDEOSOURCESERVICE_H

#include <QObject>
#include <QCamera>
#include <QVariantList>
#include <QVariantMap>

#include <QCameraInfo>
#include <QVideoProbe>

class VideoSourceService : public QObject
{
    Q_OBJECT
public:
    explicit VideoSourceService(QObject *parent = nullptr);

    Q_INVOKABLE bool selectCamera (int cameraIndex);
    Q_PROPERTY(QVariantList camerasInfo READ camerasInfo NOTIFY availableCamerasChanged)
    QVariantList camerasInfo();

signals:

    void availableCamerasChanged();

private slots:
    void _onVideoFrameProbed(const QVideoFrame &frame);

private:
    QCamera * m_pCamera = nullptr;
    QVideoProbe * m_pVideoProbe = nullptr;


};

#endif // VIDEOSOURCESERVICE_H
