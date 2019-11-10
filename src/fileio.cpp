#include "fileio.h"
#include <QClipboard>
#include <QCryptographicHash>
#include <QDebug>
#include <QFile>
#include <QGuiApplication>
#include <QStandardPaths>
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
    if (m_dir.isValid()) {
        return m_dir.path();
    }
    return "";
}

QString
FileIO::tempFile(const QString& path) const {
    QFile     file(toLocalFile(path));
    QFileInfo in(file.fileName());
    QFileInfo out(
        tempFolder(),
        QString{"dpb"}
            .append(QString::fromLatin1(fileChecksum(file)))
            .append(".")
            .append(in.suffix()));
    QFile::copy(in.absoluteFilePath(), out.absoluteFilePath());
    return QUrl::fromLocalFile(out.absoluteFilePath()).toString();
}

QByteArray
FileIO::fileChecksum(QFile& file) const {
    if (file.open(QFile::ReadOnly)) {
        QCryptographicHash hash(QCryptographicHash::Algorithm::Md5);
        if (hash.addData(&file)) {
            return hash.result().toHex();
        }
    }
    return QByteArray();
}
