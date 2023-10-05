1. Разблокировать юзеров из France и Germany с положительным балансом.

    db.users.find(
        {
            is_blocked: { $ne: true },
            country: { $in: ['France', 'Germany'] },
            balance: { $gt: 0 }
        }
    )

2. Вывести названия двух произвольных треков

    db.tracks.aggregate([
        { $sample: { size: 2 } },
        { $project: { title: 1, _id: 0 } }
    ])

3. Вывести юзеров, у которых есть треки

    db.users.aggregate([
        {
            $lookup: {
                from: 'tracks',
                localField: '_id',
                foreignField: 'author_id',
                as: 'tracks'
            }
        },
        { $match: { tracks: { $ne: [] } } }
    ])

4. Используя метод aggregate(), вывести ко-во юзеров без треков

    db.users.aggregate([
        {
            $lookup: {
                from: 'tracks',
                localField: '_id',
                foreignField: 'author_id',
                as: 'tracks'
            }
        },
        { $match: { tracks: [] } },
        { $count: 'users_count' }
    ])