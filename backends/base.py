import os
from abc import ABC, abstractmethod


class Backend(ABC):
    name = None
    artifact_extension = ""

    def artifact_path(self, build_path, src_path):
        file_base_name = os.path.splitext(os.path.basename(src_path))[0]
        return os.path.join(build_path, "{}{}".format(file_base_name, self.artifact_extension))

    def should_recompile(self, src_path, artifact_path):
        if not os.path.exists(artifact_path):
            return True
        return os.path.getmtime(src_path) > os.path.getmtime(artifact_path)

    @abstractmethod
    def compile_source(self, src_path, src_text, build_path, debug, exe_command):
        pass

    @abstractmethod
    def link_sources(self, artifacts, build_path, src_path, link_with_sdl, exe_command):
        pass
