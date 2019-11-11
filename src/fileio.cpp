#include "fileio.h"
#include <QClipboard>
#include <QCryptographicHash>
#include <QDataStream>
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

    QDataStream in(&file);
    QString     jsonFile;
    QStringList binaries;
    in >> jsonFile;
    in >> binaries;

    for (auto& binaryFileName : binaries) {
        QFile binaryFile(tempFolderFilePath(binaryFileName));
        if (binaryFile.open(QIODevice::WriteOnly)) {
            QByteArray binaryData;
            in >> binaryData;
            binaryFile.write(QByteArray::fromBase64(binaryData));
            binaryFile.close();
        }
    }
    file.close();
    return jsonFile;
}

bool
FileIO::write(
    const QString&     filePath,
    const QString&     jsonFile,
    const QStringList& binariesPath) const {

    QFile file(toLocalFile(filePath));
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return false;

    QDataStream out(&file);
    out << jsonFile;
    out << binariesPath;

    for (auto& binaryFileName : binariesPath) {
        QFile binaryFile(tempFolderFilePath(binaryFileName));
        if (binaryFile.open(QIODevice::ReadOnly)) {
            out << binaryFile.readAll().toBase64();
        }
    }
    file.close();
    return true;
}

QString
FileIO::toLocalFile(const QString& filePath) const {
    if (filePath.left(7) != "file://")
        return filePath;
    return QUrl(filePath).toLocalFile();
}

QString
FileIO::toUrlFile(const QString& filePath) const {
    if (filePath.left(7) == "file://")
        return filePath;
    return QUrl::fromLocalFile(filePath).toString();
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
FileIO::copyToTempFolder(const QString& path) const {
    QFile     file(toLocalFile(path));
    QFileInfo in(file.fileName());

    QString tempFileName{QString{"dpb"}
                             .append(QString::fromLatin1(fileChecksum(file)))
                             .append(".")
                             .append(in.suffix())};

    QFileInfo out(tempFolder(), tempFileName);
    file.copy(out.absoluteFilePath());
    return tempFileName;
}

QString
FileIO::tempFolderFileUrl(const QString& fileName) const {
    QFileInfo out(tempFolder(), fileName);
    return toUrlFile(out.absoluteFilePath());
}

QString
FileIO::tempFolderFilePath(const QString& fileName) const {
    QFileInfo out(tempFolder(), fileName);
    return out.absoluteFilePath();
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
