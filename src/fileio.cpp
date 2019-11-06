#include "fileio.h"
#include <QFile>
#include <QTextStream>
#include <QUrl>
#include <QDebug>


QString
FileIO::read(const QString& filePath) const {
    QFile file(QUrl(filePath).toLocalFile());
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return "";

    QTextStream in(&file);
    return in.readAll();
}

bool FileIO::write(const QString &filePath, const QString &data) const
{
    QFile file(QUrl(filePath).toLocalFile());
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return false;

    QTextStream out(&file);
    out << data;
    return true;
}
