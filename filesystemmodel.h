#ifndef FILESYSTEMMODEL_H
#define FILESYSTEMMODEL_H

#include <QAbstractListModel>
#include <QObject>
#include <QFileInfo>
#include <QFileSystemWatcher>

class FileSystemModel : public QAbstractListModel
{
    Q_OBJECT

public:
    FileSystemModel(QObject * parent = 0, const QString& root = "/");
    int rowCount(const QModelIndex& parent = QModelIndex()) const;
    int columnCount(const QModelIndex& parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role) const;
    void populate();

    virtual QHash<int, QByteArray> roleNames() const;

    enum Roles
    {
        FileNameRole = Qt::UserRole,
        FullPathRole,
        IsDirRole
    };

    Q_INVOKABLE void select(const QString &path);


public slots:
    void directoryChanged(const QString& newValue);

private:
   QList<QFileInfo> mDatas;
   QFileSystemWatcher fileSystemWatcher;
   QString root;
   QString currentRoot;
};

#endif // FILESYSTEMMODEL_H
