#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>

class FileIO : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE QString read(const QString& filePath) const;
    Q_INVOKABLE bool write(const QString& filePath,const QString& data) const;
    Q_INVOKABLE QString toLocalFile(const QString& filePath) const;
    Q_INVOKABLE bool fileExist(const QString& filePath) const;
};

#endif // FILEIO_H
