#include "VideoSourceService.h"

#include <QDebug>

VideoSourceService::VideoSourceService(QObject *parent)
    : QObject{parent}
{

    m_pVideoProbe = new(std::nothrow) QVideoProbe();
    if (m_pVideoProbe == nullptr) {
        qDebug() << "[unexpected] m_pVideoProbe is nullptr !!!";
    }
}

bool VideoSourceService::selectCamera(int cameraIndex)
{
    if (m_pCamera) {
        m_pCamera->deleteLater();
        m_pCamera = nullptr;
    }
    if (cameraIndex < 0) {
        qDebug() << "invalid index ( < 0)";
        return false;
    }
    if (cameraIndex >= QCameraInfo::availableCameras().length()) {
        qDebug() << "invalid index ( >= QCameraInfo::availableCameras.length())";
        return false;
    }

    QCameraInfo cameraInfo = QCameraInfo::availableCameras()[cameraIndex];
    qDebug() << "cameraInfo:" << cameraInfo;

    m_pCamera = new QCamera(cameraInfo);
    if (m_pCamera == nullptr) {
        qDebug() << "m_pCamera is nullptr !!!";
        return false;
    }

    return true;
}

QVariantList VideoSourceService::camerasInfo()
{
    QVariantList camerasInfoForQML;
    const QList<QCameraInfo> cameras = QCameraInfo::availableCameras();

    for (int i = 0; i < cameras.length(); i++) {
        QVariantMap cameraInfoForQML;
        cameraInfoForQML.insert("id", i);
        cameraInfoForQML.insert("deviceName", cameras[i].deviceName());
        cameraInfoForQML.insert("description", cameras[i].description());
        cameraInfoForQML.insert("isNull", cameras[i].isNull());
        cameraInfoForQML.insert("orientation", cameras[i].orientation());
        cameraInfoForQML.insert("position", cameras[i].position());
        qDebug() << "cameraInfoForQML:" << cameraInfoForQML;
        camerasInfoForQML.insert(i,cameraInfoForQML);
    }

    return camerasInfoForQML;
}

//bool VideoSourceService::setMonitorSource(QMediaObject *newMonitorSource)
//{
//    qDebug() << "CALLED" << __func__;
//    if (m_pVideoProbe == nullptr) {
//        qDebug() << "[unexpected] m_pVideoProbe is nullptr !!!";
//        return false;
//    }

//    bool result = m_pVideoProbe->setSource(newMonitorSource);
//    if (result) {
//        // signal connect process.

//        // disconnect old connect.
//        disconnect(m_pVideoProbe, nullptr , this, nullptr);
//        disconnect(this, nullptr , m_pVideoProbe, nullptr);

//        // connect new.
//        connect(m_pVideoProbe, &QVideoProbe::videoFrameProbed , this , &VideoSourceService::_onVideoFrameProbed);

//        return true;
//    }
//    else {
//        qDebug() << "[unexpected] result == false !!!";
//        return false;
//    }

//}

void VideoSourceService::_onVideoFrameProbed(const QVideoFrame &frame)
{
    qDebug() << "CALLED" << __func__;
    qDebug() << frame.image();
}
