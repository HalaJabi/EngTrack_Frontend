import 'package:flutter/material.dart';
import 'package:front/models/task/GetAllTask-res.dart';
import 'package:front/models/task_model.dart';

import 'package:flutter/material.dart';
import 'package:front/models/task/GetAllTask-res.dart'; // Ensure correct import path
import 'package:front/models/task_model.dart'; // Ensure correct import path
/*
class TaskCard extends StatelessWidget {
  final GetAllTaskRes task; // Define task

  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<GetAllTaskRes>( // Change Task to GetAllTaskRes
      data: task,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: Text(
        task.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
      ),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildCardInfo(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCardInfo(BuildContext context) {
    return [
      const SizedBox(height: 10),
      Text(
        task.title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 5),
      Text(
        task.note, // Use task.note instead of task.description
        maxLines: 2,
      ),
      const SizedBox(height: 10),
    ];
  }
}




*/













/*
  Widget _buildCardAdditionalInfo() {
    return (task.commentCount > 0 || task.attachmentCount > 0)
        ? Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: [
                (task.commentCount > 0)
                    ? Row(
                        children: [
                          Text('${task.commentCount}'),
                          const SizedBox(width: 5),
                          const Icon(Icons.comment),
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(width: 10),
                (task.attachmentCount > 0)
                    ? Row(
                        children: [
                          Text('${task.attachmentCount}'),
                          const SizedBox(width: 5),
                          const Icon(Icons.link)
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _buildImage() {
    return (task.image == null)
        ? const SizedBox()
        : ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: task.image!,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          );
  }
}
*/

/*

class TaskCard extends StatelessWidget {
  final GetAllTaskRes task;

  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<GetAllTaskRes>(
      data: task,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: Material(
        child: Text(
          task.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildCardContent(context),
      ),
      child: _buildCardContent(context),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            task.note,
            maxLines: 2,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
*/

class TaskCard_copy extends StatelessWidget {
  final GetAllTaskRes task;

  const TaskCard_copy({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<GetAllTaskRes>(
      data: task,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: Material(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                task.note,
                maxLines: 2,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildCardContent(context),
      ),
      child: _buildCardContent(context),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
         'Note:${ task.note}',
            maxLines: 3,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
