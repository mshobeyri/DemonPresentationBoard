#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QTemporaryDir>

class FileIO : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString read(const QString& filePath) const;
    Q_INVOKABLE bool    write(
            const QString&     filePath,
            const QString&     jsonFile,
            const QStringList& binariesPath = {}) const;
    Q_INVOKABLE QString toLocalFile(const QString& filePath) const;
    Q_INVOKABLE QString toUrlFile(const QString& filePath) const;
    Q_INVOKABLE bool    fileExist(const QString& filePath) const;
    Q_INVOKABLE void    copyToClipboard(const QString& text) const;
    Q_INVOKABLE QString getClipboard() const;
    Q_INVOKABLE QString tempFolder() const;
    Q_INVOKABLE QString copyToTempFolder(const QString& path) const;
    Q_INVOKABLE QString tempFolderFileUrl(const QString& fileName) const;
    Q_INVOKABLE QString tempFolderFilePath(const QString& fileName) const;
    Q_INVOKABLE QString getImageData(const QString& fileName) const;
    Q_INVOKABLE QString openFilePaht() const;

    void setOpenFilePaht(const QString& filePaht);

private:
    QTemporaryDir m_dir;
    QByteArray    fileChecksum(QFile& file) const;
    QString m_openFilePath{""};
};

#endif // FILEIO_H
