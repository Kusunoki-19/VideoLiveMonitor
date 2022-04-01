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

bool VideoSourceService::setMonitorSource(QMediaObject *newMonitorSource)
{
    qDebug() << "CALLED" << __func__;
    if (m_pVideoProbe == nullptr) {
        qDebug() << "[unexpected] m_pVideoProbe is nullptr !!!";
        return false;
    }

    bool result = m_pVideoProbe->setSource(newMonitorSource);
    if (result) {
        // signal connect process.

        // disconnect old connect.
        disconnect(m_pVideoProbe, nullptr , this, nullptr);
        disconnect(this, nullptr , m_pVideoProbe, nullptr);

        // connect new.
        connect(m_pVideoProbe, &QVideoProbe::videoFrameProbed , this , &VideoSourceService::_onVideoFrameProbed);

        return true;
    }
    else {
        qDebug() << "[unexpected] result == false !!!";
        return false;
    }

}

void VideoSourceService::_onVideoFrameProbed(const QVideoFrame &frame)
{
    qDebug() << "CALLED" << __func__;
    qDebug() << frame.image();
}
