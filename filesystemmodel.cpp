#include "filesystemmodel.h"
#include <QTimer>
#include <QDir>
#include <iostream>

FileSystemModel::FileSystemModel(QObject * parent, const QString& root)
{
    Q_UNUSED(parent)

    this->root = root;
    this->currentRoot = root;
    fileSystemWatcher.addPath(root);
    populate();

    connect(&fileSystemWatcher,
            SIGNAL(directoryChanged(const QString &)),
            this,
            SLOT(directoryChanged(const QString &)));
}

int FileSystemModel::rowCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent)

    return mDatas.size();
}

int FileSystemModel::columnCount(const QModelIndex& parent) const
{
    Q_UNUSED(parent)

    return 1;
}

QVariant FileSystemModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role)
    {
    case Qt::DisplayRole:
    case FileNameRole:
        return mDatas.at(index.row()).fileName();
    case FullPathRole:
        return mDatas.at(index.row()).absoluteFilePath();
    case IsDirRole:
        return mDatas.at(index.row()).isDir();
    }

    return QVariant();
}

QHash<int, QByteArray> FileSystemModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[FileNameRole] = "fileName";
    names[FullPathRole] = "path";
    names[IsDirRole] = "isDir";
    return names;
}

void FileSystemModel::directoryChanged(const QString& newValue)
{
    Q_UNUSED(newValue)

    populate();
}

QStringList videoExtensions = {"mp4","avi"};

void FileSystemModel::populate()
{
    beginResetModel();
    mDatas.clear();

    int len = fileSystemWatcher.directories().size();
    if (len > 0)
    {
        QDir dir(fileSystemWatcher.directories().first());
        for (QString directory:dir.entryList(QDir::AllEntries | QDir::NoDot | QDir::NoSymLinks))
        {
            if (currentRoot == root && directory == "..") continue;
            QFileInfo qFileInfo = QFileInfo(QFile(currentRoot + "/" + directory));
            if (qFileInfo.isFile() && !videoExtensions.contains(qFileInfo.completeSuffix())) continue;
            mDatas.append(QFileInfo(QFile(currentRoot + "/" + directory)));
        }
    }
    else
    {
        fileSystemWatcher.removePaths(fileSystemWatcher.directories());
        fileSystemWatcher.addPath(root);
        currentRoot = root;
        // here would ne a nice place to emit a signal for unmounted filesystem (root lost basically)
    }
    endResetModel();
}

Q_INVOKABLE void FileSystemModel::select(const QString &path)
{
    currentRoot = path;
    fileSystemWatcher.removePaths(fileSystemWatcher.directories());
    fileSystemWatcher.addPath(currentRoot);
    populate();
}

