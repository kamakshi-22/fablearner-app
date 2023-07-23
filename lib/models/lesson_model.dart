// To parse this JSON data, do
//
//     final lessonModel = lessonModelFromJson(jsonString);

import 'dart:convert';

LessonModel lessonModelFromJson(String str) => LessonModel.fromJson(json.decode(str));

String lessonModelToJson(LessonModel data) => json.encode(data.toJson());

class LessonModel {
    int id;
    String name;
    String slug;
    String permalink;
    DateTime dateCreated;
    DateTime dateCreatedGmt;
    DateTime dateModified;
    DateTime dateModifiedGmt;
    String status;
    String content;
    String excerpt;
    bool canFinishCourse;
    String duration;
    Assigned assigned;
    Results results;
    String videoIntro;
    MetaData metaData;

    LessonModel({
        required this.id,
        required this.name,
        required this.slug,
        required this.permalink,
        required this.dateCreated,
        required this.dateCreatedGmt,
        required this.dateModified,
        required this.dateModifiedGmt,
        required this.status,
        required this.content,
        required this.excerpt,
        required this.canFinishCourse,
        required this.duration,
        required this.assigned,
        required this.results,
        required this.videoIntro,
        required this.metaData,
    });

    factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        status: json["status"],
        content: json["content"],
        excerpt: json["excerpt"],
        canFinishCourse: json["can_finish_course"],
        duration: json["duration"],
        assigned: Assigned.fromJson(json["assigned"]),
        results: Results.fromJson(json["results"]),
        videoIntro: json["video_intro"],
        metaData: MetaData.fromJson(json["meta_data"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "date_created": dateCreated.toIso8601String(),
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt.toIso8601String(),
        "status": status,
        "content": content,
        "excerpt": excerpt,
        "can_finish_course": canFinishCourse,
        "duration": duration,
        "assigned": assigned.toJson(),
        "results": results.toJson(),
        "video_intro": videoIntro,
        "meta_data": metaData.toJson(),
    };
}

class Assigned {
    Course course;

    Assigned({
        required this.course,
    });

    factory Assigned.fromJson(Map<String, dynamic> json) => Assigned(
        course: Course.fromJson(json["course"]),
    );

    Map<String, dynamic> toJson() => {
        "course": course.toJson(),
    };
}

class Course {
    String id;
    String title;
    String slug;
    String content;
    String author;

    Course({
        required this.id,
        required this.title,
        required this.slug,
        required this.content,
        required this.author,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        content: json["content"],
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "content": content,
        "author": author,
    };
}

class MetaData {
    String lpDuration;
    String lpPreview;

    MetaData({
        required this.lpDuration,
        required this.lpPreview,
    });

    factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        lpDuration: json["_lp_duration"],
        lpPreview: json["_lp_preview"],
    );

    Map<String, dynamic> toJson() => {
        "_lp_duration": lpDuration,
        "_lp_preview": lpPreview,
    };
}

class Results {
    String status;

    Results({
        required this.status,
    });

    factory Results.fromJson(Map<String, dynamic> json) => Results(
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
    };
}
