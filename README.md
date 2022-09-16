# Overview

A very simple sequential, extensible task execution framework.
(It's technically a DAG :P but yeah it's just a list of tasks to run in serial)

# Details

* Task (`task.rb`): A small unit of work. In your `process.yaml` each task has:

    * `type`: Task classname. The class must extend the Task class. Instance of the task is created with reflection.

    * `input`: A hash object that will be passed into the task constructor. Can contain anything.

     * `parent_task_name`: A reference to another task that is part of the process. A reference to that task will be stored on this task which allows easily utilising its output.

* Process: (`process.rb`): A collection of sequential tasks to be performed.

    * A simple example of a process is defined in `data/simple_example_process.yaml`

General:

* Define your process with multiple Tasks
* Extend `Tasks` class to implement the behaviour of your newly defined Tasks
    * The magic should happen in `perform`
* Create an instance of `Process` and pass in your process yaml file. Task instances will be created for you.
* Call `run` on your process instance
* Profit?

# How to run

Just run `stepper.rb` with Ruby to see an example

# TODOS

* Status & Result fields
* Multiple Parent Tasks
* Name passed to init
* Error checks
    * Check that references exist
    * Useful errors
* Auto task ordering. Maybe just at a very basic level
* Refactor deserialisation into base Task
* Bells and whistles
    * Pretty print output
    * Summaries
    * UI
