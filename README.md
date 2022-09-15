# Overview

A very simple sequential, extensible task execution framework.
(It's technically a DAG :P but yeah it's just a list of tasks to run in serial)

# Details

* Task (`task.rb`): A small unit of work. In the `process.yaml` each task has:

    * `type`: Name of the class that extends the Task class. Must be exact as class instances are created based on this string

    * `input`: A hash object that will be passed into the task constructor. Can contain anything.

    * `parent_task_name`: A reference to the another task instance will automatically be recorded on the relevant task for easy reference. This allows easily using the output of one task in another.

* Process: (`process.rb`): A collection of sequential tasks to be performed.

    * A simple example of a process is defined in `data/simple_example_process.yaml`

General:

* Define your process with multiple Tasks
* Extend `Tasks` class to implement the behaviour of the Tasks
* Create an instance of `Process` and pass in the process yaml file
* Profit?

# How to run

Just run `stepper.rb` with Ruby

# TODOS

* Multiple Parent Tasks
* Error checks
    * Check that references exist
    * Useful errors
* Auto task ordering. Maybe just at a very basic level
* Refactor deserialisation into base Task
* Bells and whistles
    * Pretty print output
    * Summaries
    * UI
