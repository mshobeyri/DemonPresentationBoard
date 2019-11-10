#include "fileio.h"
#include <QDebug>
#include <QFile>
#include <QGuiApplication>
#include <QStandardPaths>
#include <QTemporaryDir>
#include <QTextStream>
#include <QUrl>


QString
FileIO::read(const QString& filePath) const {
    QFile file(toLocalFile(filePath));
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return "";

    QTextStream in(&file);
    return in.readAll();
}

bool
FileIO::write(const QString& filePath, const QString& data) const {
    QFile file(toLocalFile(filePath));
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return false;

    QTextStream out(&file);
    out << data;
    return true;
}

QString
FileIO::toLocalFile(const QString& filePath) const {
    if (filePath.left(7) != "file://")
        return filePath;
    return QUrl(filePath).toLocalFile();
}

bool
FileIO::fileExist(const QString& filePath) const {
    return QFile::exists(toLocalFile(filePath));
}

void
FileIO::copyToClipboard(const QString& text) const {
    QGuiApplication::clipboard()->setText(text);
}

QString
FileIO::getClipboard() const {
    return QGuiApplication::clipboard()->text();
}

QString
FileIO::tempFolder() const {
    QTemporaryDir dir;
    if (dir.isValid()) {
        return dir.path();
    }
    return "";
}
