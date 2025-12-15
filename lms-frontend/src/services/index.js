// Export all services for easier imports
import * as authService from "./authService";
import * as courseService from "./courseService";
import * as lessonService from "./lessonService";
import * as progressService from "./progressService";
import * as userService from "./userService";

export * from "./api";
export * from "./types";
export {
    authService,
    courseService,
    lessonService,
    progressService,
    userService,
};