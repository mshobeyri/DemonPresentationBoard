#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QTemporaryDir>

class FileIO : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString read(const QString& filePath) const;
    Q_INVOKABLE bool write(const QString& filePath,const QString& data) const;
    Q_INVOKABLE QString toLocalFile(const QString& filePath) const;
    Q_INVOKABLE bool fileExist(const QString& filePath) const;
    Q_INVOKABLE void copyToClipboard(const QString& text) const;
    Q_INVOKABLE QString getClipboard() const;
    Q_INVOKABLE QString tempFolder() const;
    Q_INVOKABLE QString tempFile(const QString& path) const;

private:
    QTemporaryDir m_dir;
    QByteArray fileChecksum(QFile &file) const;
};

#endif // FILEIO_H
